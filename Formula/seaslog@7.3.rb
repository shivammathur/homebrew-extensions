# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "349728fbc9d4ea5f84adde8a0f8230ca46a72fbd2cfc271e57ca0b0b1a0e9e19"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f418315f92eeb0ef67333388e41afbd3c400c2b928d56d2f94e3b7ccb852e04a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "36846aa6a8fea22b157d8c287c95d98d958902ced818f74862dffd681d2d8659"
    sha256 cellar: :any_skip_relocation, sonoma:        "bbc0b6b3a82a25f5e480677f3d1303bd46d3597811eac35fe4985d9f6c8d5380"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3ec1de111195980411ebb5572ba5100a29ed6549e2426a731787c88b6592a17c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2718727b2d47cc1f9482eddcfa1e1f317aee7688081dca89e0656dc66a9acd38"
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
