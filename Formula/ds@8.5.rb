# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT85 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.6.0.tgz"
  sha256 "7c5eaa693e49f43962fa8afa863c51000dc620048dcf9442453c27ca151e291e"
  revision 1
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "a0e1abf9bb2d994c62e3753ca977b8e4bd7cb2bd11af918c6cdb9a8eff164518"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6b65bbce63e89e7c8ea483453810c2279795f9095e64008f459df4651df11b9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "831fc644f80d884928f24fbd5c4b340639914c7a48587bb9d1a6cba64bcf33f4"
    sha256 cellar: :any_skip_relocation, sonoma:        "9b1a81ad494b85ae05e20dbba1f6fe1c2072dfa6d8ed18ccc2d781845eaa671c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dce41777bf83dc71b5dfea05dedce7400b1d7551aa0a4fc0853c3f9298b92f3b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d08cd826b9fd2ee21b0170119f00966b80cf85e7116cc2db1a33018f3e20b72d"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
