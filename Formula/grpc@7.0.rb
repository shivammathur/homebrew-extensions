# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.63.0.tgz"
  sha256 "0d67d0935f1e4a1feabf96a64f24e32af1918cd09ea7bef89211520f938007ca"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bbab9a074c607f2f00bd8c6ee0ec82d9299d65491c42118bb52e76d23de08067"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4c72ceedd22e19183015d7258b630ac6124efcbc00ba89ccf023deb12ecad0c6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2c1c1879088439b5c677911dc57d5234b6aad5e059f18a06fe338a7e3165d1f2"
    sha256 cellar: :any_skip_relocation, ventura:        "ca7a1193c782f67339e348061902e3331d98a0ed5ea2b40e4a3040e3323c41b5"
    sha256 cellar: :any_skip_relocation, monterey:       "1c8d0d924f48293c80e10451d2892d404cbab1a475ed13d4e51fa27d0214360a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8083cfcdbe42e9165677ad999f6c53c5d225ea51e6da485d3f3208c518800b29"
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
