# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Seaslog Extension
class SeaslogAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "6e1587b1ea0a885955faad5790981edcfcc4be1dd27d8499b6b46b4af148afc5"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6625bf6cac568dbfa534f5a1d429b8ab7f40e394874e0e908fe23f22adcfd727"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "095a34f6af58f37cc2640519a195da8bd283f89ce64e64f21417f540bdf58e6b"
    sha256 cellar: :any_skip_relocation, sonoma:        "af52a9034603485efd1df3114024c393784509e28ab19b43d109a90585e1e95a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "efb683b2f0acb2d25c767d9fb35d96a2873bd51da9fd641ecba682d02ecac06a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a1a13e99e001e41a532d78d74a9a288ac933e69bbb1beeafbdd7feeda7286423"
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
