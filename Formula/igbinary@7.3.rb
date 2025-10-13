# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT73 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.16.tar.gz"
  sha256 "941f1cf2ccbecdc1c221dbfae9213439d334be5d490a2f3da2be31e8a00b0cdb"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  livecheck do
    url :homepage
    strategy :git do |tags|
      semver_tags = tags.map(&:to_s).grep(/^v?\d+(\.\d+)+$/)
      semver_tags.max_by { |tag| Version.new(tag.delete_prefix("v")) }
    end
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:    "9eeee86028e231775f4f4bfe8f89e7490d6bae8acde95146f1ce9ff3d27f629f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "6e8d4d593f84e41387b24103839e4df60ab16f10570c46215943e44e91584929"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "313ce1e969d5383f1490b501e764967999d4a0081d898d85532bd9dbfbedfb88"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "4f54173f41be6caed364bd36d28c3607033ecbeb174caa78861169aa55d56d99"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "71b18282645208f27caca806cfe2cb410e833ce92f9f001d4ef163f1a0552429"
    sha256 cellar: :any_skip_relocation, sonoma:         "6d55de3156081bda1e1518cbc302a336f05b2e1babef22b95950e4589d7989ac"
    sha256 cellar: :any_skip_relocation, ventura:        "f6bc46ad0f67606d95ff730ffebac02c77064bd401d04345f06724f45b09b60c"
    sha256 cellar: :any_skip_relocation, monterey:       "31328ccec1aed2f19da8739923c0072377c2ffcbb04ced0e5e066b0e1c586a7b"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "94df9fecbd0e8044dc9e8d84bc8e73a5aeab188e99175df9e1ddf4f9dced20bb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6ae121c9465ea824bd53848cb4ceabfbde900d497d7a764dfde470a6ef0027a5"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
