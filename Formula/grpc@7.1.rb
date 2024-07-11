# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "bc6f98cf0a49cf83932aa295e4b5002872e0e9c8df2c471053509388166150a9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e8c99fded84d445ae6cad94c4c2fd9a833a63f0480cabca08cbb6a9713402f62"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c2f649bc4867271f2d26a5134d63d1c37c9e054144f3d2846e19fcc8ffc4863d"
    sha256 cellar: :any_skip_relocation, ventura:        "03a23f23dea9fee94fca3f5ebdb863ab27678ef0e0ec3e58f65d4fdc66f4cfa5"
    sha256 cellar: :any_skip_relocation, monterey:       "a2e86a86f01e6f53e3de8c368847ccebbf5a7449c5589c1967c5d67956e28c00"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "0d05578c3cf2d433696b85cd14aaea639148f973d1f82d9c92dde3d21e67f675"
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
