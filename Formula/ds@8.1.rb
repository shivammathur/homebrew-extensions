# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT81 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6604c0cbf153529ed493e2d62554bfb7a643611e802436cf327f436628332357"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3f25a6b03edd9027c4b30e9f83c37cf0d1a4b995ae819a7dbea8a62b7ed789ed"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1a0a7091aa3fe4d6d0fbb4e6bccbcb2921287ae8c11282fdb9b1dd0702600965"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "db8a63b41c02d1a6e71f62952f640140ba627fac77f2d69cc4dec307fe8f6a4a"
    sha256 cellar: :any_skip_relocation, ventura:        "a9bbbccc01f943ffe2468aa204b9f37dd452dc9f9cd1ee126c70835a63dac33f"
    sha256 cellar: :any_skip_relocation, monterey:       "c016cfc97d1e230ca3f973b0568ccd3feeb2f25640e31c068a959901924aae92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "e2cef025f680940f9d24165b6f5d03b2fc03e154548d6e1d79de52f528f131ba"
  end

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
