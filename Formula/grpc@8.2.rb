# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1c253e33fca82477e734b2eb20ccc2a688a72b481b4417603c7bdaa98445f465"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "90a564a3654d6a6c04d5b7a857bf2f3841197210444c0a3a5fb70ec79a685d6a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e8ecc3d7f642247f3c516dbe4ffef0e1c46e356b1f88541769350ecc6668b906"
    sha256 cellar: :any_skip_relocation, ventura:       "927a57d1d85a0295bca9da9340f5682ba466b3de8fc9a9f288f611b285321ec1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3744ddaa108bc51bde49a24cd551707c9989102d8339394e3ebc1a3ca73d294c"
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
