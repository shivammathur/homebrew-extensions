# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT70 < AbstractPhpExtension
  init
  desc "Seaslog PHP extension"
  homepage "https://github.com/SeasX/SeasLog"
  url "https://pecl.php.net/get/SeasLog-2.2.0.tgz"
  sha256 "e40a1067075b1e0bcdfd5ff98647b9f83f502eb6b2a3d89e67b067704ea127da"
  head "https://github.com/SeasX/SeasLog.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/seaslog/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7d349b6ca4cd09a9f0b8ce86652374ed27080f5fe76f576b85927379b075bb0b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b3bc33708dc749736e546436fa9c614bfd864588622fd23e97ddfed7bcfc995c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "bbee9baec46816f6e8572fd3361fbe2bf63d6fd323f4785ac2cbb2145b306a05"
    sha256 cellar: :any_skip_relocation, sonoma:        "96b1ca46386f879a3f9a719946b1a72f00547240cc32b78c2971478e855a7bda"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ac8e155b921b8c430e5572c6c46dee509328457fc77cdc123ee04be7ad3c0674"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a297dbb8f62c047e60ce728ac995cc77c65b599570153ae0b5bd801465459d8f"
  end

  def install
    Dir.chdir "SeasLog-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-seaslog"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
