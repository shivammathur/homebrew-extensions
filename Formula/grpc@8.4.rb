# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "474966f8e04a5f9098a51026d66e87724bea147e64c9fbb6bcc1b7d3b532f623"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d6ce581a5875e57b8d232ffb09fca5db151d4da37770124dcac553ea03f9a64c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8a4dbcbd4ade507305529f78023ca97fa3a0bba664e9c7500f3d08f60c39c485"
    sha256 cellar: :any_skip_relocation, sonoma:        "136ae26f8223d760b7fd0df176c8b5c542a44e7ec53283258b0dee12c5fa28b9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c546d5cf0b2f377a615fc4433dc07ddff9231107b42171cc50e475a3b2906a6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "1a608f1e7a0b5d39358eab6ee43545dc4d0a8505bdcb26164b7e6b239a25de44"
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
