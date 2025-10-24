# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8843f7ace56fe3f353e6281f1acaf03c093aea95ae60ca0adecc62b4b09c3524"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "46251e28f463c4f0bdad52bfd6932c772dca9229f4133634dfcc455256d2e904"
    sha256 cellar: :any_skip_relocation, sonoma:        "55e5d0476ec7cb3e295f772d4ca5d5dee2de217f96e41e705b17622580f707ce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8854c4e4155a0a2c4f76dd42462050176669efb4a14271bfed55cfce9a3e96e4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9b65d21dce46f267efe06f806c10e8c2f65ea0c25810339f654a1dee529c3017"
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
