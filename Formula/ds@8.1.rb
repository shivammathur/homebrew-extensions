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
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6a1ada6b19512cc037bd0f96ce8466c4d5498be5e01d0713b81814c57b748b31"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "42367db2b0d953e2c8c8202d01f4210adcf08a3a7e7a023ded36dd9526832883"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "b2dfa69470498be11e7b376717a41da80549e0649475dcaf943982fc214f5bca"
    sha256 cellar: :any_skip_relocation, sonoma:        "31d6b182fc6ca731a73ca433ec17390606d05654081951dc8755c911ecc3dd86"
    sha256 cellar: :any_skip_relocation, ventura:       "9cb6713d744c4eaac1ecc4c88bf42ab7ba0803d591ffbd03ff2b45488a6e8312"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0b8aa955c89c77fc35eff92acb25d052f71b0a9918ba2622fe3a61e9007e913"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4d9492184cc96d4ef4020aa8a6a384d24f0ec28ecae8311cdae495046c1f74c"
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
