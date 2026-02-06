# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT86 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "e5a604029ed967861feb9cce77c11b1eadd46b12332bdee347f8c428469e348a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dbcb8a22029eeb6412022ac64b15c21f0794b02e24ddd901dba9e3e9e31976a6"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "80ab9436b1f95a472ed5126252f41f2d27f3ec3b41befa6737b9dba531a8e78e"
    sha256 cellar: :any_skip_relocation, sonoma:        "0d5c206d03cb5516f7134d504c10cc820357b27a5d7728b4b0d0ffaa63653c58"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "05288a6dd570f441069e8a539f00c6e5c6c2ac56f62196544e04c067e696e2d3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04bd78eb9c7738c515ecaceae32f1845dd3fa201660c0f38472c1466aa511a6a"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
