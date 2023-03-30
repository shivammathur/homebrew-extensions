# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "50c612af054d382b90d5f76eb5989887211168609ea57ee95c47132d06e96f82"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "09cf861ce2e8bcdfb09e008cac8da31e6d2b73705b3035605c89cfa97b151f85"
    sha256 cellar: :any_skip_relocation, monterey:       "23113ab4dacedb932ec9d155573b27813716ec959b32bcb85ae812d3d1e63c08"
    sha256 cellar: :any_skip_relocation, big_sur:        "3376a43882ccb0c5d7c87766f0b3908069d899cdd967adcb6e19dc2a81eb3d8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24ca2319477ffa2ab0b56dc1c9a55b8051acc7f4396519876c07149637c81361"
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
