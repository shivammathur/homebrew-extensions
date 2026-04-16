# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT86 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "ed6739e6720da7cf5004c38dd439ffc216cbfa242798ba638be2e3a48a1758ee"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "967a24aff35a7f78f7e3793800e2dc50fae665a45613ae9a1ea6f182518e4075"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "feda4f21494aec7154b6c90d684fc68685542412300e884f75ed601de9d8172d"
    sha256 cellar: :any_skip_relocation, sonoma:        "425b204a55f6cc77c43f29e4f7d693409204bf43cfc4b9d7d80a239ad8b73615"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3cea68a52e64f6f196a1012be9adaf48bea1de8059c48a5ee3d456087850b2b7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18b0a3b17986138bca3ac26dcb6131903f938c42142f726828eb6541f3330627"
  end

  def install
    Dir.chdir "excimer-#{version}"
    inreplace "excimer.c", "INI_INT(", "zend_ini_long_literal("
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
