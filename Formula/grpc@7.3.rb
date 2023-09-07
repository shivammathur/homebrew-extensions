# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.58.0.tgz"
  sha256 "083e6460e111cc09a12f749329eac1bb40b21ec728a10230f8942111500625f9"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ba72de1b4eb5dad1066519b64b608f989c942bf144a7391fe0b043261c0cd373"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f76c545ef80db262139e1ae19215f80f1e028dc538baf6a780db320f80e8123c"
    sha256 cellar: :any_skip_relocation, ventura:        "b1e82ccb8ba93d0df3e1a96c15a254bb37109f57ceee11b3c9c1f0cdb3b95f9b"
    sha256 cellar: :any_skip_relocation, monterey:       "85420b4c3313b32235fba7e30ffed3d8ef5372f129895711a50436213111b7e9"
    sha256 cellar: :any_skip_relocation, big_sur:        "2c5ab1a2551842a254a657c4a959c6fe82d84ab48b9b193c3fdec5fde3c48d52"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f9c7f70f5f12a8a3347b1aab0c5faf41b4975f08ea9b70fe0c930a2043c41122"
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
