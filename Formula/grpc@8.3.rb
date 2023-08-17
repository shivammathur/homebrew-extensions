# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4bd152bbfd2f9b18d4b8188c2168556fbce8f7a78e16459c409cb35bd189828e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "28f22839c6ce7eaaac945f851cc6311a28274045f308b20e1434470299175a19"
    sha256 cellar: :any_skip_relocation, ventura:        "76a8796b5745a5d2371cfb0bb7986eb53dd23272e1efdf51c5e1080eb745bab1"
    sha256 cellar: :any_skip_relocation, monterey:       "419c75acf25cee2b3705bdfdb3e222912d7129de9e7ce240132aa18c2cd7dba9"
    sha256 cellar: :any_skip_relocation, big_sur:        "ed5575074946fe5e9997c29ec19d059ba0d1407a50864c32042e76e499b04e0d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "016567e00aa03d7720d9889806fe4756e44e83ac3588daf0d467591d2c89d185"
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
