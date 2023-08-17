# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.57.0.tgz"
  sha256 "b1ae19706fd3968584ed3079986b4cf1d6e557fc336761a336d73a435b9a7e60"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "143f469b84dce9412ef15e2c3917bdef3fc7695fb71c34d5012adf01e946607d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "74dac3d3a4541e20a172e4fee802475ef827efd077c221e1c9bb8eb922669605"
    sha256 cellar: :any_skip_relocation, ventura:        "52093dbdb60bf6a0147070be8945b0b72ed3d961071ac37f787334bb7fc8991e"
    sha256 cellar: :any_skip_relocation, monterey:       "0db97d97d7052e5bec27da2e13f09d6dd47f2c86fce98b253e096b7bbb928490"
    sha256 cellar: :any_skip_relocation, big_sur:        "c7bbdc8e9b378b06c68e276dbc6b329fac665ea30c56263555b2c45838ae3c67"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1385f740821138740bf6d7802295ed7cd2116c5cb49cd169a761a43efaf446d6"
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
