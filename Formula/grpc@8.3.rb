# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.60.0.tgz"
  sha256 "171f490b5426de76b479036c95d4c1ca44bb1a3fb42999e938d2c59fcbceed32"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bd12589a365209fc34e0d556db04648b4f5e9532f07c3e1518bda4320de56c39"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a4718e62ea6f498e0279b23c546445f835090753aa3756d786627c065f133e9f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4a5f002566b4964c58686e101de5d69997ff00e170ab950934e44edda333b35d"
    sha256 cellar: :any_skip_relocation, ventura:        "7aa2f0022d9e44e3f9ecff6378e0e67e5f42a01ecd11eb72b2bde7b03c507730"
    sha256 cellar: :any_skip_relocation, monterey:       "44020408c0698ddbb15674fe378c292096f8ccb0b8ce5bccb843f8e5886b7475"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d92c3053bf9ed7deebec5e4e2fe42bf4e6dacce59b46fd4de849fc9da9e802f6"
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
