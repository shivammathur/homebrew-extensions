# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT81 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "895071d85ca7fcd71ce898c47987b5bdc0f00e67c67f57e228a660864ef07e7d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "588bdd4c2bc454b9a63e4aa2128535bd480540f9e0ae854ba2e7a056bce4aca7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "e970b36948ca18b957d00e92ab49dc1cdb6ce04975f4b1a018b2a6560d0c61ec"
    sha256 cellar: :any_skip_relocation, ventura:       "32f9a117f681ac5fd17140492efcb1156922ff3455bd7e1f2b7448a94589c42c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e7dd14d4a7c5d635d8b2fe291c8ceaacea0ddd4ce22a6e5c7e890f90e1472357"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ba26b476637e747b11e11c45cf3e6bfa8125c6de9b789d4090237a0a2961a81e"
  end

  def install
    Dir.chdir "raphf-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
