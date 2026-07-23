# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6fa5ed08898cb95ce0ec223907f46243918919d133788511f1e9695bb4192aa1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a5da726482a2fbffe6194eea2578c56476f1eb90e4a29f9a065816b4f666fbeb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a7e882a73bbf9cca5f0128adcf3cc6ebc8e1652051e1e667d74b9cbf20f48e38"
    sha256 cellar: :any_skip_relocation, sonoma:        "c391fea3f0bc43ad9cf42758e87eb97c62f788f9701fcb8b5390861bfbabd19a"
    sha256 cellar: :any,                 arm64_linux:   "f3deade3d7dd54d83103434a0128cdf8b5d61f41d7e26cae92af2b5871926ed1"
    sha256 cellar: :any,                 x86_64_linux:  "3d195dc71f8759bfcdd2f15f646a520ce2419cf745d02dbe45eda67d2e84298d"
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
