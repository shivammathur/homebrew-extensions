# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.80.0.tgz"
  sha256 "75e553f2b5c3f7dde99aa984a9601dce6db240bc3c85d7fe09298b5bd8c5d53f"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8c492cff42e9d85f08ec293ef81361bbeee6e855cf0498fde484c1f2dcd1a2aa"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d9838f401f5a82bfd4ceace2a6255815425eae88ae829aba52826873f052f8c6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2f2b602f8e710ce31f8aa5a34ab900b8a8c50cadaaaf2285f44c7d6f74c88cb0"
    sha256 cellar: :any_skip_relocation, sonoma:        "873b1bbc85f540b6fc929410423333d423f64dd939e9b9080bc13f6487aaad24"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e2c248ddc48c2631a420f6172c0dfd29f1a87fc8ab53c0aaf654ee914d4c62fb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7307bbffdde8c3e855f447dafa8bcfa3abea90e98e6bd4cfdec743b85ea4f03c"
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
