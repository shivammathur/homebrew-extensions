# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f08c99d3c892e8c025658f9f733ed0172938fb4eff788cf1b567d2eb7476510c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a60ebb691f7926792d5d70531c0afdbe8f525bc6b4f8cf2842a80aedcaeb3ab8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f4e032cb1dccb407663fc79d66f6b96e41672bfb1e96e002ece9c11f88949e91"
    sha256 cellar: :any_skip_relocation, sonoma:        "8566602c5372fcec00161adf5551a072c6bc65f6aeebbe8dd91a10ef47e1b57c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8c597db2622415165f192ad55306205fcbd297b5858e24cc5fd0614a0ab114e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3cfea79bca1555e55579033c2ead9d73fb025d0d15a9767ca3c39d7a22991be3"
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
