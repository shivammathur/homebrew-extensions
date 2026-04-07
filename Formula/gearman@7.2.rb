# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "feb0e6fcec107fdc1a7a751d6ade90a50fdafc05f057491668048ae046f79e03"
    sha256 cellar: :any,                 arm64_sequoia: "e75e4b0d4c78f0664c0db0310942b604661be9c56076f18c5e4b96c7c7c34a36"
    sha256 cellar: :any,                 arm64_sonoma:  "48e7e2d8c29884891310f7a681caf401137cf603c86d6b5e143478699b1d1a1a"
    sha256 cellar: :any,                 sonoma:        "d6709c549c4eabb2e8b5e6215a223e05d9a49487d7a8ebe2dbbd88438167619a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7799d8451fb114abc305ce72c7d86a490d60fd8bdc61763b81832e74b5d1615e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "37eaa32aeda27eb9b69a5ab09c0955ced77107b2c740121e568f640492acbf3e"
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
