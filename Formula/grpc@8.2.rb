# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.44.0.tgz"
  sha256 "f6d6be7e1bd49b3aae7ada97233fe68172100a71a23e5039acb2c0c1b87e4f11"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "755b4451beac479daa1f1d4a342d4e125efd45adaae173bd7151b7159ac67fbf"
    sha256 cellar: :any_skip_relocation, big_sur:       "6fc197636752d6b268c5284ba3b67d68d1fb1b902e672ddd702c5928d654608f"
    sha256 cellar: :any_skip_relocation, catalina:      "8f628b405e812daca9324025e2e6c9b08998c2fc775c4065717321a2b2b240a6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4adb98a2f5602cddbed2922a374c257a34f65652a14cab488d1edd5830fc76e6"
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
