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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4fb2781bb1987cb2c68e2090de3a926a61cc4e8cc49d555408e2cfb0df3499ae"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "acb2d2e575dc515dca1dd360520e36d203c32961c0c29de7862bdde70068bacb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f0d7042b0818055c09df33cd5276f3da1de66f4300cf4cc12246d48305dd0df3"
    sha256 cellar: :any_skip_relocation, sonoma:        "032f9b1ad4e9796b785e72114edad84bfee6a4ebca387fc466179f89dd68b40d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "47c0f862a319df31d560d7bacff4da55fdb0e3c72fe8afd5d2c021a39c9d64cd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6af2db2457b4a2306d4e2589f6d2c0a9302fa5c3375e771c9beda0896dcc650e"
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
