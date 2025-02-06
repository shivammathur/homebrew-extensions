# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "75c77d8021b2c1e9c4bc9c3833607be606ee16d3c11f98abf54486e32773bf1a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9f23ed78ce8aac7f8a39b8bee1e11d5003d68b294e577344cbfb2a9edd045d90"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "cd0d1edb64292769f4aba739ebd02c35c29d6c36984cac775dbeaff9caee2329"
    sha256 cellar: :any_skip_relocation, ventura:       "83ef8f988fa2322d35d15593cf0803ab653906b3cceee4daf969843146707728"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "86003e80626ff00cd0710141ac5464ebe51d4d0ed42a12ac12c287ca81589015"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
