# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.1.tgz"
  sha256 "8331f47cf760dbaf13ae2d77d63971005b03df40279dec97ede4b537d14c9591"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0c96f50a8e15777371f0f97188bcbd28ccb6c95b1ef4739ee496325230ca1843"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1376bb094dc4533cc1fdee719e97b5a224ce5f2e292a5aa17d831b642f17e998"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cf986ded7ca1d713828d56aabe97f4ac7cfd70ee032dff342afe0be01cfa55fa"
    sha256 cellar: :any_skip_relocation, sonoma:        "9b6a6b4e49adee13ef478c442dbaad0bf35d3480b02c6136ccb6467066619e78"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f33d2300a4ec4a6b4cd2948706e07c9b402c94627ce72bcef9f1693bc095582f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "04f1e985cdb25ede2eda1190022de041724ccf93911c4b814df237b438dc2740"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
