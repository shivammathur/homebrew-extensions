# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "77a8a4bc49793cbad90391a70c9fb903ad1879915d172b74bd4cc519d12d9a7e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "697137b5286cb88c5793b86352e68e4efcedf294950ad036005556fcd5772783"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9db7ecf366f542c18c927bafa13971c9d27e57c0d2e0ac1db0564222c67808ab"
    sha256 cellar: :any_skip_relocation, sonoma:        "73f32a18bcc880351c2c4a3560c8a958046acf3809849109fc70360834cb459e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "69ed2a8077a41b04a19302f06c41004c9e2c9e885bfb1aceb472ef44f50ce373"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "904ddba577be71e943d4b2121bc18fd36a587b36283bcae48b4bcc13a545a45a"
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
