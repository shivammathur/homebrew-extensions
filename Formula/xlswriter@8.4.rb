# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT84 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-3.0.0.tgz"
  sha256 "a17986ad5ac09529513fc59b2871ca2b53eaec1c2c55cf00be60a292e85ade73"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3af5b5dbad0243d3c3a93ceeeb8a9557bf5330b49731311b626c01f05a3cb71e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "38c92e80f39d1980d87ed2067d21c0740141a934fca4ea454897af1da7329050"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "995bae10e4d73caccb509ce0b33e3cf6a91242afabd593e2f176a96c85555948"
    sha256 cellar: :any_skip_relocation, sonoma:        "08cc3d76baccd5c9fe8c4f80f1cda795f9978fccd623fbbe2280eca0bc5780f4"
    sha256 cellar: :any,                 arm64_linux:   "bd070ba8dc4168bbdc393885aa186ca67ba65d391dd70c9ce20e997225f49a91"
    sha256 cellar: :any,                 x86_64_linux:  "485a4cbd81841e1786c8a9eec3de36b8fa46e79ba02cac34bfe084f722b3bf89"
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
