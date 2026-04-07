# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT86 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "49dfecc871626f4dc78b56fc9eca6e41e2f3a55edf3a9fe6bc0b5e0c71b1099f"
    sha256 cellar: :any,                 arm64_sequoia: "d6943760f5a6a0cfdce0f0e5b749a71fbaa767370762704b71ffc25b0bc86c3e"
    sha256 cellar: :any,                 arm64_sonoma:  "76fba838ad37d317675b609785cc9326d4adf41a97636dac2df8588976d2c752"
    sha256 cellar: :any,                 sonoma:        "bf64cc80c18bcb6fa766afb7e3e56f10786269f5b38a541c5063f36c61831bd8"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4dd5aed94899bbf1c92c06b818eff11a300a9e3f464da827ebe42307fba09a02"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "867b93954ee334b1195e4ce89598549b2bf3f6def45860c7f17cd29186f8ea0a"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
