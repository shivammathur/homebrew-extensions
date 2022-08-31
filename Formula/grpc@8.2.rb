# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.48.0.tgz"
  sha256 "4b4ccb491355f938d28e63a476df92d5109263ea63ffee1e0249616461e26963"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "325e1673197619d92ab2fa099516e2e91cf8fcf6b2bb4dcd7ab91ce57828bc6d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b0ff6b1bf71f1009969fd496c2b98b995b40cf19762d24fcd26c24a10aa1dd73"
    sha256 cellar: :any_skip_relocation, monterey:       "6343d89d9319b131f559b1c1287a88567599d2eb28ab81dbb8df67fe687d7460"
    sha256 cellar: :any_skip_relocation, big_sur:        "367c0728bf53e2869b26d36f293a5783a0cb23b15ad34684b6a9300f5e99e52b"
    sha256 cellar: :any_skip_relocation, catalina:       "6894197582dd9ba0fe1ca68812aa4d866d8a543e059ddd3a8b0e5dd6471a0119"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e622c025b434e1e2e3ab4fb8bb6961a0597623e6a01b77f7119be68755b282b"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
