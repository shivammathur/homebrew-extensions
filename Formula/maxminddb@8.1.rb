# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Maxminddb Extension
class MaxminddbAT81 < AbstractPhpExtension
  init
  desc "MaxMind DB Reader PHP extension"
  homepage "https://github.com/maxmind/MaxMind-DB-Reader-php-ext"
  url "https://pecl.php.net/get/maxminddb-1.14.0.tgz"
  sha256 "c06351f1360bd651057ea73e0186d8fec744292839a4b49c71ce886072c4fff7"
  head "https://github.com/maxmind/MaxMind-DB-Reader-php-ext.git", branch: "main"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/maxminddb/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "7c321cf879acf2a4d12356991eda4aefdd892d48c6cdf67ff90bff9b11e9c6cb"
    sha256 cellar: :any, arm64_sequoia: "6e5552a403c5ae8a624eebbbfe942a2edb21d3334f1d0fa1710b46e6e4f44142"
    sha256 cellar: :any, arm64_sonoma:  "35ccefea98d40b399382d5032c6b64832f52c7d6de8e996d60c5929247bd343e"
    sha256 cellar: :any, arm64_linux:   "060029dfcbe3f4a8e83cbd3e2d4e71bb99c618cafbe25321631db0a3462d91c7"
    sha256 cellar: :any, x86_64_linux:  "dea2ae0a16655657a7fdd749307eb3b873257adb4c3b59fa57680fff28080c7b"
  end

  depends_on "libmaxminddb"

  def install
    Dir.chdir "maxminddb-#{version}/ext"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-maxminddb"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
