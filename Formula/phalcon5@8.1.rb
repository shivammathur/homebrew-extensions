# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.10.0.tgz"
  sha256 "3b552ac17fae44512298f43ec47cd055679d40e8c74b782743021dce77859eb1"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1ead2fdbcd539a6334a41c0624c80e2dafafdbff142f49a8ad348585e118eedf"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "ef0f7c74fc846a9a5df5140993a964bfca914c215c76d4b95f7d182cf3554205"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "4fa223a08052924205648e14e875a5bf689c31881eb6f0ae80dedb61dd1163e7"
    sha256 cellar: :any_skip_relocation, sonoma:        "710491d0f2fac51218dca796de30280e864f2d042fbd2015e431290892916a34"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "06fadc11ab2a5c5282b028e2bb645f52085d3e1a83301b3e0f11d55209ca1251"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ca8f8e44f9587fd65bd2b0bad37270f47351deeb79d4364cbd99ac8c8fe93e9b"
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
