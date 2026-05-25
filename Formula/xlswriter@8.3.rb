# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT83 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.1.tgz"
  sha256 "279749cbe22858af2f69958eeefea3060a2e6545fda1f8fc0fceba0a44f29a20"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2d85db0dddebf6095f9701379e86148a9fca962bfd56a9b10654348f3065f6bd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b59162a7c4003473701076a352cdcb05d6e727370d1af7c1bbef84e04ba7a9eb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9d44fe9ce0ea51e30aafefec138977183b3579be2b9777e3dacc9f3c078088bc"
    sha256 cellar: :any_skip_relocation, sonoma:        "fc020cd0d9af53a10bb5306c090719dd303239ed1b3bd21a73d35cb0af9e4b98"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "950c1851b207a47a7df8e4953df5a5066282dedead38ec7811c715db765112ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ad6905b6a72e1677618ca3fd9dfd6af9e6866ac039a00257eff78dcc1ff48e3d"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
