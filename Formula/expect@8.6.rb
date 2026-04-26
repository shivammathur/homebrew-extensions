# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Expect Extension
class ExpectAT86 < AbstractPhpExtension
  init
  desc "Expect PHP extension"
  homepage "https://github.com/sibaz/pecl-expect"
  url "https://pecl.php.net/get/expect-0.4.0.tgz"
  sha256 "032ff2f92a9f95a2cb91d9e1c1b711c696e562ea57cdec8459954d8b0601d442"
  revision 1
  head "https://github.com/sibaz/pecl-expect.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/expect/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "7ca22b9a6b4cba1364cf19a9ee4742060a453b80affb19333e9aab2902f3c326"
    sha256 cellar: :any,                 arm64_sequoia: "4f193915b5c04677bc7cdb991db84d0209b197c83f244ca277ca552cfbb4ac4b"
    sha256 cellar: :any,                 arm64_sonoma:  "967b1b4df348fb8196278403af0c578a2b7145651d01ecd45d5261074ed14b57"
    sha256 cellar: :any,                 sonoma:        "5e47ac1a88702159ec7c29e1ec7bd56a17dc6013dcfeb26ee2fea3928c4298aa"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3ab8dabafbba26cb1683cb2b7405fc463933514d9d6cc3934615c7c9e96a82db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "78eb1b78fe38324cecc180f975b1fd253905f860678353ed3f6ea2718aa1bc19"
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
    ENV.append "CFLAGS", "-I#{buildpath}/expect-#{version}/include"
  end

  def install
    args = %W[
      --with-expect=shared,#{Formula["expect"].opt_prefix}
      --with-tcldir=#{Formula["tcl-tk@8"].opt_prefix}/lib
    ]
    add_expect_lib
    add_expect_headers
    Dir.chdir "expect-#{version}"
    inreplace "expect_fopen_wrapper.c", " TSRMLS_DC", ""
    inreplace "expect.c" do |s|
      s.gsub! " TSRMLS_CC", ""
      s.gsub! "ulong", "zend_ulong"
    end
    inreplace "expect.c", "zval_dtor", "zval_ptr_dtor_nogc"
    inreplace "expect.c", "WRONG_PARAM_COUNT;", "zend_wrong_param_count(); RETURN_THROWS();"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
