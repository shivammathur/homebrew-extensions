# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.70.0.tgz"
  sha256 "11336d7bc4465148db506348006dd5559ce478eee4bf1b080bb31b89de6974b7"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "167e44537edb9ffd97d7ce374da7ddf252b9010f99aea57b69f5f3d9b4d658ee"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "dd34a48d66229d8604a6c3913d3b2d17bc39828da5ba8b78cffc587e70eb683b"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "0b99e4df6c9ccc043b79ec4cc04ef1f03a53386be261b924e1a33358afa503c4"
    sha256 cellar: :any_skip_relocation, ventura:       "cc2ea66531f3ec3588a8ff12ea879ab3dcf9a531cc584dadae21b72620bc6705"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "21a5be83f1ac46dac8547ffc8a3b41f826b3a79ddda683a6ccf4a22150ff72e9"
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
