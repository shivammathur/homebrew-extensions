# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT72 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "305e4194e0e6ad0a1e78c8b12f068e02f17a79d0e7a90dd1dc664fe46011b682"
    sha256 cellar: :any, arm64_tahoe:       "509b652d82b050ccddc88443987105ae4fb9620af1c7edad907c364faef77d17"
    sha256 cellar: :any, arm64_sequoia:     "1d5dbe11f8b497821b93022d35c64221000c9df0102e77fedbfb652b77bca658"
    sha256 cellar: :any, arm64_linux:       "5d0e0f35fd559d82a537c1ede15721f93a3df9a724cc490022af3c025136746c"
    sha256 cellar: :any, x86_64_linux:      "2c97ae64524298a31691027fa94a991e2b27b8471a24ca0a9c27847242f1c820"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    inreplace "ssh2_fopen_wrappers.c" do |s|
      s.gsub! "ZSTR_VAL(resource->path)", "SSH2_URL_STR(resource->path)"
      s.gsub! "zend_string_release(resource->path);", "efree(resource->path);"
      s.gsub! "zend_string_init(path_in_original, strlen(path_in_original), 0)", "estrdup(path_in_original)"
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
