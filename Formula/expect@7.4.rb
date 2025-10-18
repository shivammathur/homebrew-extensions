# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT74 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia: "75403bfb7a390ba3a5d45890f4b74ea26480636fa1c668499b23a0dcb72e36bc"
    sha256 cellar: :any,                 arm64_sonoma:  "8a464af8b4b6bf04fd97dd8e766979006a46bb119cf8b66fcf17b444e1933159"
    sha256 cellar: :any,                 arm64_ventura: "5b0a7f9f0e724bc95b2f0f84b947e01b6cda31f27006e3abb888e6a73eeab220"
    sha256 cellar: :any,                 sonoma:        "846870218885a279594887b23995cafd7f8f7fd20a831c199f55ae55e63c7cc1"
    sha256 cellar: :any,                 ventura:       "51cb9c79e410f5ba3aee2fa2076037c792d70db2e92e59f39dc608994758a657"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "fff3135f2df8216666769484afc947365348fb3250f57286fc4c17244caefcd7"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e7d40bc989e9e37997f94327ce3b58e1c41fbd636c1d1a2e372457aed2bf36fd"
  end

  depends_on "expect"
  depends_on "tcl-tk@8"

  def add_expect_lib
    expect_lib = Dir["#{Formula["homebrew/core/expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  def add_expect_headers
    headers = Dir["#{Formula["tcl-tk@8"].opt_include}/**/*.h"]
    (buildpath/"expect-#{version}/include").install_symlink headers unless headers.empty?
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect.c", "ulong", "zend_ulong"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
