# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.20.2.tgz"
  sha256 "d16b250a1efe85b7083125731a5f664ac6bc16114e09da5f63fac085769cc48d"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d019f41e639a1a65f17c072b6e8c18f6c30a8e1e9ccfe3cd2b9ce45bdbdb8ae5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "52ea0494dc1b431974077d9d97f1ef25381142eb8995380929c60b4267cf3a24"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "39956a8e59c907689b5a42024c08e26d7971fbf3b21f91277410b9dad104bbe4"
    sha256 cellar: :any_skip_relocation, sonoma:        "d6e131823f754c8e097499d78e907f1032799b6302bdf2352c72ba6b887347b9"
    sha256 cellar: :any,                 arm64_linux:   "8471fbcbb6b663640c5367b92ef5ddfa84169f286f597f86c40eed3601ad57f8"
    sha256 cellar: :any,                 x86_64_linux:  "640bf95cea7fdfdd5c21045d16eef4dd4feaa9342ea044aad20ab1894da07624"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
