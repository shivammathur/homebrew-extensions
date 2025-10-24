# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c6c59f0563463c773ac1daa35fe42c5b5c7cea86764752916f2c43452cfb3217"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b2b644b2f1b36608b3902f7fa3edf0524e7bcd95d4d67d4d152d675ee3977c22"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6b4b8d96931c6b8773eced36dbadde359a35012868409fa6c7dabd5d6364595c"
    sha256 cellar: :any_skip_relocation, sonoma:        "32b778ce6715d32b1db44c927755aa45d2c024e0ec519de9275c106f161f4d92"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7a547522e502eb312d0a06455146bb5e492ce26ba56828ee466ce2c07cfb50c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "553d2447c257982eeb678ff26362207ebe0b57ad3a1c094a20d06ed48109411a"
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
