# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.81.1.tgz"
  sha256 "3c9086743a29bda3b5bd323e31f9c6da6e04900288ab37f0da1df8859a2ee8f5"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2a4ad1494a512f6c8435d1d6e735dbde29eb8e9d161ab6038564cb017851f6d5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1a47c66fcd2fcb5982c75c25f5dfc4a3a6a8bf0c00696b992c9a8c2429c3fcbb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a8e687402693d756e6513efcf7dc88ff44b255255def70a45133a31b763dabeb"
    sha256 cellar: :any_skip_relocation, sonoma:        "4ba850a5c5875ad579d1f8b5461ca140a64b699f94181a4ad704d2c824078600"
    sha256 cellar: :any,                 arm64_linux:   "59bf9e381f32d2eb1b3c5c30fc04a62a79340b8080aef5f902db18310b131176"
    sha256 cellar: :any,                 x86_64_linux:  "50afd66206b1b64bbd1e1e9ad29371c1449f6dc60c406bfcf4fca6de5c1ea7a1"
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
