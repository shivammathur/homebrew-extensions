# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2770dfb7d4d514d8d42de48727ce44129b2b92d92e21f2c000b1efb983e13e56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1087ce34d4696c381e4958c7cd6afc1c2e228f1c7b9a171435a831aa40630095"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "451286c4feafa1bf4777f116bb5e0300b463ddd74a437610b7e426e6360f7d03"
    sha256 cellar: :any_skip_relocation, ventura:       "c8449d4dc9b0e6c9d537d8ba39b1ec8c6dcc06429484aafdeb3a1f6fd452d271"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a17d7ad8f4532d7257e65e57bb15dc6a101bb520a44336df58b8aa1c73baa969"
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
