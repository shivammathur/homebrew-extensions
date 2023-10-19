# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.59.1.tgz"
  sha256 "d789aab7c791647907c3bc3af2bd6b6e97348d1b50eaa59826be61c4a3c3d3ee"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "f1dec813f92f2b1790b2c52bfa78566f80a42f5ae6a381885d60b62d12d55258"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "10551396045991cd56758b9ba4d48dfedfc67236f694fbb6f5af8c3fda2ff969"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2b9eccaa50d724ac02416a08bab1280c84d0b8d271d68a6281a8fa4971fd17ec"
    sha256 cellar: :any_skip_relocation, ventura:        "68980c865d00278461c5dab6a1b0bbc2affa531e0f6bdd092e3df9f2aac15e3a"
    sha256 cellar: :any_skip_relocation, monterey:       "7961e6792dff4008d2352d5644f62cedc5bed09e9938627b1133191a04070e00"
    sha256 cellar: :any_skip_relocation, big_sur:        "da9f50d53cbede45ca7cfc368027924eadfd64b3fcac4a0a38ccbf390a139283"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a5ad5dbcd087d458998b475d3e7789972322d6b90040a565bf63854107b94496"
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
