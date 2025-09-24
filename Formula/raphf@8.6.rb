# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ebc8f113433a22c778f668d03ec84633bc5298d5a89b405b74867737fc67b6ef"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c6b68ad13e6b2d4d93ae85d5b63b9393cc86fe8f59916ad22cc71c53189eb9ee"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ea3605ed07c91f5d54d240fa7848ccfcad8eecdc0d167b523749d8c42adafa06"
    sha256 cellar: :any_skip_relocation, sonoma:        "b28ee18ae65309cc31e9a98d57ef74be1b650c3e654398b1cc03717b991a14ac"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6f73e4fdd8c1f38befc0d3b8a00d97daca09a29986f2d766f623d3603471ce5f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d40f177d66f3fbb9ce049104b048d4ff66efa0a8b20cbf47c1b8aec148d01f2a"
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
