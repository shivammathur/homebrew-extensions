# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.73.0.tgz"
  sha256 "63959dc527c60cdb056842c5e5ebb45b507452bb121653604ed94c1c23972c7d"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "101e40ff1fb318542dd712ed0dd3957528d6723ad7e042000bff1ba38505389b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1ad0cce0e3081430f3c645b6b411c609f23f4ce40297eca421fed158060d1724"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b61a9d6487cb2cf749214f175ba20b8ffa0029d27bb776da47287b377d8a8d9f"
    sha256 cellar: :any_skip_relocation, ventura:       "63951eb6f7568f7ba35006aaba9f6aa39e689f3cd10048d5efdb71e317e63266"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "70d4bd357725208cfd61a2d0d54f154f32e7a3fe6c31bcfb91990dbb77c83708"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8359d0692baebdfb26f8212be50f890b2bf71f4703a064b43f765343838b0a22"
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
