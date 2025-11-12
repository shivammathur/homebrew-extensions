# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Yaml Extension
class YamlAT84 < AbstractPhpExtension
  init
  desc "Yaml PHP extension"
  homepage "https://github.com/php/pecl-file_formats-yaml"
  url "https://pecl.php.net/get/yaml-2.3.0.tgz"
  sha256 "bc8404807a3a4dc896b310af21a7f8063aa238424ff77f27eb6ffa88b5874b8a"
  head "https://github.com/php/pecl-file_formats-yaml.git", branch: "php7"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/yaml/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "6a2147ec15201a880d8a5a1688a73e09f18440d54ffa67f7ba13d202ea5431b8"
    sha256 cellar: :any,                 arm64_sonoma:  "4647a3462d6f96a40f66b5c4a28219f4249ab53f26d7ce663fc68b4bdf292856"
    sha256 cellar: :any,                 arm64_ventura: "0552475059ffa867a6b8257f05ef457f1181b6a747805a9ba72ea6a81986b4d1"
    sha256 cellar: :any,                 sonoma:        "607bf40adf5a2d09feaafc50cd38427c8e62b49be0c0e8837b69957d7466a0cf"
    sha256 cellar: :any,                 ventura:       "0b6ad0890db8378ed784d775630913eabe2b67a9b3a5a102c1e6b99b99fe5c8d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d96ef85d88a38f5db2a2a4c20b24c4146b769060261fde65da994ca251f59eef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d8672eb221c572b36001e57d3f186350bf759ce498ed3f7793d0963516ac0280"
  end

  depends_on "libyaml"

  def install
    args = %W[
      --with-yaml=#{Formula["libyaml"].opt_prefix}
    ]
    Dir.chdir "yaml-#{version}"
    inreplace "detect.c", "ZEND_ATOL(*lval, buf)", "*lval = ZEND_ATOL(buf)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
