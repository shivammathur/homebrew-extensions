# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT71 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "509f878015e7fc4735cdebddd07a78e5252981b52ae3eeaca5cb0d23f483e63c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8d7807e275969369d81673442049ded3d8d30638dafb081f05492ab32065f0f6"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dd42c37c68eea1a1f1211c6ea0f9184f533cdd127b74bb3d11a43280e9b8bb50"
    sha256 cellar: :any_skip_relocation, ventura:       "4b512fd4f2f0c5473e084ec819247df748d29ff9df73a0fe9a34bfc7e78cf989"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "73f7e285e28a94b941e439ab40d01d586043aa7aa6d161449ad48c9eb4000142"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "53a0d87d05cfa6c0294f00526180af31cf8707e8e9677c2fac89b77f895d73d6"
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
