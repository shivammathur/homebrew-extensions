# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1ec3ba1463d114f710d7c7ca942ce952539980a4f5d77f9de7ef78eb1e902d51"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a6e17cf0dffcd7adf4d14d8dcd12316af8b7e9d3bd38b395e26483ce7a0fb101"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "11a50f70f538aa4e1a3b05fd7925bfd636b98f73731cde8e7594abbee3aaa559"
    sha256 cellar: :any_skip_relocation, sonoma:        "86de53969f5abd9b8f7b137e6e2886bef704bd6053951846dd04621fd99074ea"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "25a7eb7346ea747355680874d72c6feb060bc40d12c759297aa023c3476cab85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ddf7202747f3c39c1225a398fdf77bd30033b94fc8d2b3e3344ef6ccc9ec82f6"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
