# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "092f6ee847453e528502a460329bbca6655ca3295b4029c8cd1b609e240cf885"
    sha256 cellar: :any,                 arm64_sequoia: "a6603debd7378ed175fe4bad0b7addbdaaafcf81a3c99431d84c5fba70bfcb0a"
    sha256 cellar: :any,                 arm64_sonoma:  "2b22d89374bfb73f75ea9946db7c1983649deba88d8d4fb0a25d542817cec4a0"
    sha256 cellar: :any,                 sonoma:        "942adb5bbdf4b2e6dc7ee8e84785b44e709d754ed951ada6284dba9cac8d7a0c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b5db33e07cf311e94a9a63d618c7b2d00a735ce6d290bf30f839e5ce69f1bf04"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "903e3f3c09d69ab902dc66a704bdbbad634d7ed4ce5bd05f36135e6f6f4647d5"
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
