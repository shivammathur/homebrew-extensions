# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT83 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "396bd68b2f81eeb717c9a495e658a405f159721a317977c7747a7edacd02fd3c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "55e5bf353b2c3db894ab8ce4ed53d501fc283baf0e40c86e9d8eb92caa2cbfee"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "de855e2eb7b4c912de466576da6f5d392230b3e69feef2f92fcda8f3105aa3ee"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "59af9de9a8426757e7db0d9ebadaaa2271256ce975070f2e9df21b950e9b4a58"
    sha256 cellar: :any_skip_relocation, ventura:        "a08798829322db20e7b4daf46ffa7590a2c0e0d1f7b1a94ac8727d001fbab059"
    sha256 cellar: :any_skip_relocation, monterey:       "82ed75f07100933ce46d7ae6c4a8af924a08e8836b059835f689159dc5151ba1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b544804bc8c77aae02a7a23a29f4b921943d3643fa0e3f30ba439c269a6d5aa9"
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
