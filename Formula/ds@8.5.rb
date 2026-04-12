# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT85 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "88a33d52773fedbf47895b14b291449ce0c366a88228889d3f0cfdc34acfe357"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "96e3acf3657b95cf5d5212b2beda70c1cc8f8b802f721c2012b11bdaa446fd56"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a08a280f373db5fff7e46a451659aa9a663f258f835667dd53c82fdbf3699ca3"
    sha256 cellar: :any_skip_relocation, sonoma:        "6e876cab835889655328be7aec5ddc4752b677ad203b32e8c0385da0914f863d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "062ab7165eaf30583592bc73008481612a711dff4fb65ab8e50e66aabcb7adf0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e5b03b28ecd64bb9b8b555ca843079156ccbec953ef228b7e92d97775fe6c16"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
