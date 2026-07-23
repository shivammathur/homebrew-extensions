# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.83.0.tgz"
  sha256 "b12c7e0e048df728a4f2c513aeaa78ae18ad5c3ab3b607eeae398e0e1bab12ea"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bbd358254d06f3c135c514e55b72130914afe764bdb44cd373ab819d2006eb13"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2c060bb23437bce490bb4c6cbd7ab8b46d529e7393af4d9c53b1bcccd57e947b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "23b56fc68a986143a001d5c7a836ec51b61a57d9a9814e1447c2a6d2f3f1530c"
    sha256 cellar: :any_skip_relocation, sonoma:        "ac7a6487caed3beedef35586e17d11f8827f67c02c3d9b340a04c72388aea941"
    sha256 cellar: :any,                 arm64_linux:   "8f247271d2bc6ba126937bbe4bf8eeeaec6f76713e1a40729123a61817e763bf"
    sha256 cellar: :any,                 x86_64_linux:  "d0bca2311f34c85e01531628866804491111acf71780bab94dc26861467ecf7f"
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
