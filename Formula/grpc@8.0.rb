# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.76.0.tgz"
  sha256 "6e3d65695bb99de227054ae6431cee29cebabdee699ded55e97fc6f892eb4935"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cfb3bb88a7ce79128474987aa36cb9d8405f0d619b1f52c95a39b478c177754f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4bed608337c57b0cb698e8be1b176038dad3e964274d8350fbf841fb1785e716"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "af0787d163f706d1167bf91c27f59be4202fc552eb7355937ed43ecaa55a7a0c"
    sha256 cellar: :any_skip_relocation, sonoma:        "6dc71c1d3dd505babd4dc2bc653093b1d84a41f512439493c6b87025566668e2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f18630d8835730b6d0cfc56e38833ee4a2d17d6ffbd4f8e23ecce2497cbe4835"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "23431bdfc639e8c49cbda2c6ef4f9d181142336236c0fcd7ae3c7a64b230a1a4"
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
