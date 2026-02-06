# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT71 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.1.4.tgz"
  sha256 "9ba0f010f78889b8d69c5c643a9c920d1e140cd1d06817b8bf4ee76f996138c0"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "73ba411f403214be1e7e02c25e654e5b6dd0f0cae55c29ac8382580d8324acfc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "968fcdffdb50601dc010d55faee7972a514aa1afb62fe96123986518b18f5ed7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b160d9888e72c6cdadb3c2e07cb8dac2b676e4d4515f129c8cd95436edae1798"
    sha256 cellar: :any_skip_relocation, sonoma:        "2ff4ea0ec8d27766aa865508f0f7981ba2184a78902b20eeed38f950defea6c6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "6cf8753341dfc54728b3b3867baf729c6f845a715c9ffcd22dce89b1766f5468"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e9b4df53cd2518750a3f34286f3c8cec27275abff162167320d0ddcc04cbc8fb"
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
